if [[ -z "${DOTFILES_LIB_DIR}" ]];
then
  echo "DOTFILES_LIB_DIR is not set" >&2
  exit 1
fi

if [[ -z "${DOTFILES_LIB_EXTENSIONS_DIR}" ]];
then
  echo "DOTFILES_LIB_EXTENSIONS_DIR is not set" >&2
  exit 2
fi

# shellcheck source=../../../lib/logger.sh
source "${DOTFILES_LIB_DIR}/logger.sh"

# shellcheck source=../../../lib/extensions/homebrew.sh
source "${DOTFILES_LIB_EXTENSIONS_DIR}/homebrew.sh"

brew_casks_to_trust=(
  "nikitabobko/tap/aerospace"
)

brew_formulas_to_trust=(
  "felixkratz/formulae/borders"
)

for brew_cask_to_trust in "${brew_casks_to_trust[@]}";
do
  dotfiles::logger::debug "Trusting brew cask: $brew_cask_to_trust"
  if brew trust --cask "$brew_cask_to_trust";
  then
    dotfiles::logger::success "Trusted brew cask: $brew_cask_to_trust"
  else
    dotfiles::logger::error "Failed to trust brew cask: $brew_cask_to_trust"
  fi
done

for brew_formula_to_trust in "${brew_formulas_to_trust[@]}";
do
  dotfiles::logger::debug "Trusting brew formula: $brew_formula_to_trust"
  if brew trust --formula "$brew_formula_to_trust";
  then
    dotfiles::logger::success "Trusted brew formula: $brew_formula_to_trust"
  else
    dotfiles::logger::error "Failed to trust brew formula: $brew_formula_to_trust"
  fi
done

dotfiles::logger::debug "Installing the Homebrew bundle..."
if dotfiles::extensions::homebrew::bundle::install;
then
  dotfiles::logger::success "Homebrew bundle installed successfully."
else
  dotfiles::logger::error "Failed to install Homebrew bundle."
fi
