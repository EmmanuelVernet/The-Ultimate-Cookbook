import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  connect() {

  }

  processImage(event) {
    const fileInput = event.target;
    console.log(fileInput.files);
    if (fileInput.files[0] ) {
      console.log("hello again")
      const form = fileInput.closest("form");
      form.submit(); // Automatically submit the form once a file is selected
    }
  }
}
