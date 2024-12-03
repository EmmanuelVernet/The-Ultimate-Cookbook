// app/javascript/controllers/search_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form", "checkbox"];

  submitForm() {
    this.formTarget.submit(); // Soumettre le formulaire automatiquement
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
