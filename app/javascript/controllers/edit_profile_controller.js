import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-profile"
export default class extends Controller {
  static targets = ["details", "form"]

  showEditForm() {
    this.detailsTarget.hidden = true
    this.formTarget.classList.remove("hidden")
  }

  hideEditForm() {
    this.detailsTarget.hidden = false
    this.formTarget.classList.add("hidden")
  }
}
