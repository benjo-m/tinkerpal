// app/javascript/controllers/tab_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab"]

  select(event) {
    const clickedTab = event.currentTarget

    this.tabTargets.forEach(tab => {
      tab.classList.remove("bg-gray-200", "text-red-500")
    })

    clickedTab.classList.add("bg-gray-200", "text-red-500")
  }
}
