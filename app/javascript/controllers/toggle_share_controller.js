import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-share"
export default class extends Controller {
  static targets = ["togglableElement", "togglableTag", "togglableDiv", "togglableDivTag"]

  connect() {
    console.log("Hello")
  }

  fire() {
    this.togglableElementTarget.classList.toggle("d-none");
    this.togglableDivTarget.classList.toggle("d-none");

  }

  tag() {
    this.togglableDivTagTarget.classList.toggle("d-none");
    this.togglableTagTarget.classList.toggle("d-none");

  }
}
