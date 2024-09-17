import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['memberCard', 'toggable', 'editButton']

  connect() {
    // Ensure all toggle elements are hidden on load
    this.toggableTargets.forEach(toggableE => {
      if (!toggableE.classList.contains('d-none')) {
        toggableE.classList.add('d-none')
      }
    });

    console.log("connected")
  }

  toggleEdits() {
    this.toggableTargets.forEach(toggableE => {
      toggableE.classList.toggle('d-none')
    });

    this.editButtonTarget.classList.toggle('active')

    if (this.editButtonTarget.textContent.trim() === "Done Editing") {
      this.editButtonTarget.textContent = "Edit Members"
    } else {
      this.editButtonTarget.textContent = "Done Editing"
    }
  }
}
