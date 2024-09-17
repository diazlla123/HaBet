import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-members"
export default class extends Controller {
  static targets = ['memberCard', 'toggable']
  connect() {
    console.log("conectado")

  }

  toggleEdits (){
    this.toggableTargets.forEach(toggableE => {
      toggableE.classList.toggle('d-none')
    });
  }

}
