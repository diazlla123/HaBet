import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["taskForm", "placeholder"]

  connect() {
    console.log("Connected")
    this.index = 1;
  }

  addTask(event) {
    event.preventDefault();
    const newTask = this.taskFormTarget.cloneNode(true);
    newTask.innerHTML = newTask.innerHTML.replace(/\[0\]/g, `[${this.index}]`);
    this.placeholderTarget.insertAdjacentHTML('beforeend', newTask.innerHTML);
    this.index++;
  }
}
