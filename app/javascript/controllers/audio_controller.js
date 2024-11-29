import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  play(event) {
    event.preventDefault(); // Empêche le comportement par défaut de l'ancre
    // Récupérer le chemin du fichier audio depuis data-audio-file
    const audioPath = event.currentTarget.dataset.audioFile;
    if (!audioPath) {
      console.error("Aucun fichier audio spécifié.");
      return;
    }
    // Créer un élément audio temporaire pour jouer le son
    const audio = new Audio(audioPath);
    audio.play().catch((error) => console.error("Erreur lors de la lecture audio :", error));
  }
}
