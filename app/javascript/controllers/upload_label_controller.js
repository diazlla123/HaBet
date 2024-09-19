import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload-label"
export default class extends Controller {
  static targets = ["Label", "inputField"]

  connect() {
    console.log("hello mom!")
  }

  update() {
    // console.log(this.inputFieldTarget.files[0].name)
    // console.log(this.LabelTarget.innerText)
    this.LabelTarget.innerText = this.inputFieldTarget.files[0].name
  }
}
