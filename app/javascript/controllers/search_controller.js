// app/javascript/controllers/search_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form", "checkbox"];

  submitForm() {
    this.formTarget.submit(); // Soumettre le formulaire automatiquement
  }

  // Carousel homepage
  searchWithKeyword(event) {
    const keyword = event.target.dataset.keyword;  // Récupère le mot-clé de l'icône cliquée
    this.inputTarget.value = keyword;  // Met à jour le champ de recherche avec ce mot-clé
    this.keywordTarget.value = keyword;  // Met à jour le champ caché avec le mot-clé (pour les recherches par mot-clé)
    this.formTarget.submit();  // Soumet le formulaire
  }

  connect() {
    // Ajoute l'événement de changement pour chaque checkbox
    this.checkboxTargets.forEach(checkbox => {
      checkbox.addEventListener('change', this.submitForm.bind(this));
    });
  }

  disconnect() {
    // Nettoyage des écouteurs d'événements lorsqu'on déconnecte le contrôleur
    this.checkboxTargets.forEach(checkbox => {
      checkbox.removeEventListener('change', this.submitForm.bind(this));
    });
  }
}
