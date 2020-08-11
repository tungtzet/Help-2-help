// app/javascript/plugins/init_autocomplete.js
import places from 'places.js';

const initAutocomplete = () => {
  const addressSearch = document.getElementById('address-search-home');
  if (addressSearch) {
    places({ container: addressSearch });
  }

  const addressForm = document.getElementById('profile_address');
  if (addressForm) {
    places({ container: addressForm });
  }
};

export { initAutocomplete };