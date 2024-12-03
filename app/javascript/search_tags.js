
  const checkboxes = document.querySelectorAll('.tag-selector input[type="checkbox"]');
  console.log("Script chargé et écouteur prêt");

  checkboxes.forEach(function(checkbox) {
    checkbox.addEventListener('change', function() {
      console.log("Changement détecté sur une case à cocher");
      this.closest('form').submit();
    });
  });
