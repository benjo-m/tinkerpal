import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review-modal"
export default class extends Controller {
  close(e) {
    e.preventDefault();
    const modal = document.getElementById("review-modal");
    modal.innerHTML = "";
  }
}
