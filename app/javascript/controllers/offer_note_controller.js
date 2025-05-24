import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["note", "backgroundDiv"]

  show() {
    this.noteTarget.classList.remove("hidden")
    this.backgroundDivTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")
  }

  close() {
    this.noteTarget.classList.add("hidden")
    this.backgroundDivTarget.classList.add("hidden")
    document.body.classList.remove("overflow-hidden")
  }
}
