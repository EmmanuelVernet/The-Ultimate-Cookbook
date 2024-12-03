import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["togglableElement", "addtoggle"]

  connect() {
    console.log(this.togglableElementTarget)
    console.log("coucou")
  }

  fire() {
    this.togglableElementTarget.classList.toggle("d-none");
    this.addtoggleTarget.classList.toggle("d-none");
  }
}
