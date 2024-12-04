import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-share"
export default class extends Controller {
  static targets = ["togglableElement"]

  connect() {
    console.log("Hello")
  }

  fire() {
    this.togglableElementTarget.classList.toggle("d-none");
  }
}
