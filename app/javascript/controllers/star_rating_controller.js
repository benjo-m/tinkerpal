import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["star", "input"]

  connect() {
    this.selectedRating = 0
  }

  hoverStar(event) {
    const hoveredIndex = this.starTargets.indexOf(event.currentTarget)

    this.starTargets.forEach((star, index) => {
      if (index <= hoveredIndex) {
        star.classList.remove("bi-star")
        star.classList.add("bi-star-fill")
      } else {
        star.classList.remove("bi-star-fill")
        star.classList.add("bi-star")
      }
    })
  }

  selectStar(event) {
    this.selectedRating = this.starTargets.indexOf(event.currentTarget) + 1
    this.inputTarget.value = this.selectedRating
  }

  resetStars() {
    this.starTargets.forEach((star, index) => {
      if (index < this.selectedRating) {
        star.classList.remove("bi-star")
        star.classList.add("bi-star-fill")
      } else {
        star.classList.remove("bi-star-fill")
        star.classList.add("bi-star")
      }
    })
  }
}
