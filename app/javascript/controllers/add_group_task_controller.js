import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-group-task"
export default class extends Controller {

  static targets = ["togglableElement"]
  connect() {
    console.log("Connected")
  }

  addTask() {
    this.togglableElementTarget.classList.toggle("d-none");
  }
}
