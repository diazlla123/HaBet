import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toogle-delete-group"
export default class extends Controller {
  connect() {
  }

  showButtonsDeletes() {
    const allGroups = document.querySelectorAll(".delete-button")
    allGroups.forEach(group => {
      group.classList.toggle("d-none")
    })
  }
}
