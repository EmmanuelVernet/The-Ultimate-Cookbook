import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "icon"];

  connect() {
    console.log("hello")
  }

  processImage(event) {
    console.log("world")
    const fileInput = event.target;
    console.log(fileInput.files);
    if (fileInput.files[0] ) {
      console.log("hello again")
      const form = fileInput.closest("form");
      form.submit(); // Automatically submit the form once a file is selected
      // this.element.submit(); // Automatically submit the form once a file isselected
      // document.body.innerHTML = "";
      this.iconTarget.innerHTML = `
       <i class="fa-solid fa-camera fa-beat fa-2xl icon-couleur-vert"></i>
      `
    }
  }
}
