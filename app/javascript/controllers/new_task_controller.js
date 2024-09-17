import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["taskForm", "placeholder", "addButton", "toggleBtnRemove", "deleteTask", "taskName"]

  connect() {
    console.log("Connected")
    this.index = 1;
  }

  addTask(event) {
    event.preventDefault();

    //Agrega el delete button
    this.taskNameTarget.classList.remove('col-8');
    this.taskNameTarget.classList.add('col-6');
    this.deleteTaskTarget.classList.remove('d-none')

    const newTask = this.taskFormTarget.cloneNode(true);
    newTask.innerHTML = newTask.innerHTML.replace(/\[0\]/g, `[${this.index}]`);
    this.placeholderTarget.insertAdjacentHTML('beforeend', newTask.innerHTML);
    this.index++;

    // Change the style of buttons
    // this.addButtonTarget.classList.remove('col-12');
    // this.addButtonTarget.classList.add('col-5');
    // this.toggleBtnRemoveTarget.classList.remove('d-none');
    // console.dir(this.placeholderTargets);
  }

  toggleRemove (event) {
    event.preventDefault();
    this.deleteTaskTargets.forEach(deletes => {
      deletes.classList.toggle('d-none');
    });

  }

  removeTask(event) {
    event.preventDefault();
    // event.target.closest('.row').remove();
    const taskFormElement = event.target.closest('.task-form');
    if (taskFormElement) {
      taskFormElement.remove();
    }
    const taskCount = this.element.querySelectorAll('.task-form').length;

    // Mostrar el conteo en la consola
    console.log(`Número de tareas restantes: ${taskCount}`);

    // Puedes hacer algo condicional según el conteo
    if (taskCount === 1) {
      console.log("No quedan tareas.");
      // Change the style of buttons
      this.taskNameTarget.classList.remove('col-6');
      this.taskNameTarget.classList.add('col-8');
      // this.toggleBtnRemoveTarget.classList.add('d-none');
      this.deleteTaskTarget.classList.add('d-none');
  }
  }
}
