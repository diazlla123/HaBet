import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toogle-delete-group"
export default class extends Controller {
  static targets = ['deleteButton', 'toggleButton']

  connect() {
    // Ensure all delete buttons are hidden on load
    const allGroups = document.querySelectorAll(".delete-button")
    allGroups.forEach(group => {
      if (!group.classList.contains('d-none')) {
        group.classList.add('d-none')
      }
    });

    console.log("connected")
  }

  showButtonsDeletes() {

    const allGroups = document.querySelectorAll(".delete-button")
    allGroups.forEach(group => {
      group.classList.toggle('d-none')
    });

    this.element.classList.toggle('active-toggle');
    
    if (this.element.textContent.trim() === "Delete Group") {
      this.element.textContent = "Done"
    } else {
      this.element.textContent = "Delete Group"
    }
  }
}
