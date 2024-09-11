import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="group-member"
export default class extends Controller {
  static values = { groupId: Number }

  connect() {
    this.createMember()
  }

  createMember() {
    const url = `/groups/${this.groupIdValue}/members` 
    fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json",
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content") }
    })
      .then(response => response.json())
      .then(data => console.log(data))
  }
}
