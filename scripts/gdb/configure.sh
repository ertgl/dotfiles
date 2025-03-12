# Based on:
# https://github.com/conda-forge/gdb-feedstock/blob/a7366427d58c6e6d46cbf03da9d554ec4bb48a92/recipe/macos-codesign/macos-setup-codesign.sh

if [[ $(type -t dotfiles::paths::loaded) != function ]];
then
  echo "Error: dotfiles::paths::loaded is not a function" >&2
  return 1
fi

# shellcheck source=lib/logger.sh
source "${DOTFILES_LIB_DIR}"/logger.sh

dotfiles::logger::debug "Generating and installing gdb_codesign certificate"

CERT="gdb_codesign"

function error() {
  echo error: "$@" 1>&2
  return 1
}

function cleanup {
  # Remove generated files
  # shellcheck disable=SC2317
  rm -f "$TMPDIR/$CERT.tmpl" "$TMPDIR/$CERT.cer" "$TMPDIR/$CERT.key" > /dev/null 2>&1
}

trap cleanup EXIT

# Check if the certificate is already present in the system keychain
if security find-certificate -Z -p -c "$CERT" /Library/Keychains/System.keychain > /dev/null 2>&1;
then
  echo Certificate has already been generated and installed
  return 0
fi

# Create the certificate template
cat <<EOF >"$TMPDIR/$CERT.tmpl"
[ req ]
default_bits       = 2048        # RSA key size
encrypt_key        = no          # Protect private key
default_md         = sha512      # MD to use
prompt             = no          # Prompt for DN
distinguished_name = codesign_dn # DN template
[ codesign_dn ]
commonName         = "$CERT"
[ codesign_reqext ]
keyUsage           = critical,digitalSignature
extendedKeyUsage   = critical,codeSigning
EOF

echo Generating and installing gdb_codesign certificate

# Generate a new certificate
if ! openssl req -new -newkey rsa:2048 -x509 -days 3650 -nodes -config "$TMPDIR/$CERT.tmpl" -extensions codesign_reqext -batch -out "$TMPDIR/$CERT.cer" -keyout "$TMPDIR/$CERT.key" > /dev/null 2>&1;
then
  error Something went wrong when generating the certificate
fi

# Install the certificate in the system keychain
# shellcheck disable=SC2024
sudo security authorizationdb read com.apple.trust-settings.admin > "$TMPDIR/rights"
sudo security authorizationdb write com.apple.trust-settings.admin allow
sudo security add-trusted-cert -d -r trustRoot -p codeSign -k /Library/Keychains/System.keychain "$TMPDIR/$CERT.cer" > /dev/null 2>&1
result=$?
# shellcheck disable=SC2024
sudo security authorizationdb write com.apple.trust-settings.admin < "$TMPDIR/rights"
[ $result -eq 0 ] || error Something went wrong when installing the certificate

# Install the key for the certificate in the system keychain
if ! sudo security import "$TMPDIR/$CERT.key" -A -k /Library/Keychains/System.keychain > /dev/null 2>&1;
then
  error Something went wrong when installing the key
fi

# Kill task_for_pid access control daemon
sudo pkill -f /usr/libexec/taskgated > /dev/null 2>&1

# Exit indicating the certificate is now generated and installed
return 0
