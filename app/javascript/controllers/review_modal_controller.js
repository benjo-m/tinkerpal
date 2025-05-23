import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.body.classList.add("overflow-hidden")
  }

  disconnect() {
    document.body.classList.remove("overflow-hidden")
  }

  close(e) {
    e.preventDefault()
    const modal = document.getElementById("review-modal")
    modal.innerHTML = ""
    document.body.classList.remove("overflow-hidden")
  }
}
