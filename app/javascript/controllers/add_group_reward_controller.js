import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-group-reward"
export default class extends Controller {

  static targets = ["togglableElement"]

  connect() {
    console.log("Connected")
  }

  addReward() {
    this.togglableElementTarget.classList.toggle("d-none");
  }
}
