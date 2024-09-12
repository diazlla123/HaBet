import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-group-punishment"
export default class extends Controller {
  static targets = ["togglableElement"]

  connect() {
    console.log("Connected")
  }

  addPunishment() {
    this.togglableElementTarget.classList.toggle("d-none");
  }
}

// mamamadas
