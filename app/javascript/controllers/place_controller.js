import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="place"
export default class extends Controller {
  static targets = ["output"]

  connect() {
    console.log("connected-place")
    const place = this.outputTarget.innerText
    switch (place) {
      case "1":
        this.outputTarget.innerText = "1st Place"
        break;
      case "2":
        this.outputTarget.innerText = "2nd Place"
        break;
      case "3":
        this.outputTarget.innerText = "3rd Place"
        break;
      default:
        this.outputTarget.innerText = `${place}th Place`
        break;
    }
  }

}
