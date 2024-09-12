import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-copy-link"
export default class extends Controller {
  connect() {
  }

  copyLink() {
    const valueCopy = document.querySelector("#linkToCopy").textContent.trim()
    navigator.clipboard.writeText(valueCopy).then(() => {
      alert("Copied the text: " + valueCopy)
    }).catch(err => {
      console.error('Error copying text: ', err)
    })
  }
}