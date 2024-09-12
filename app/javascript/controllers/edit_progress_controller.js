import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-progress"
export default class extends Controller {
  static targets = ["togglableElement"]

  connect() {
    console.log("yes")
  }

  toggle() {
    this.togglableElementTarget.classList.toggle("d-none");
  }
}
