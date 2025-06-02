import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="skills-modal"
export default class extends Controller {
  static targets = ["editButton", "modal", "bgDiv", "skillsDiv", "checkboxesDiv"]

  show() {
    this.modalTarget.classList.remove("hidden")
    this.bgDivTarget.classList.remove("hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
    this.bgDivTarget.classList.add("hidden")
  }

  update() {
    const checkedBoxes = this.checkboxesDivTarget.querySelectorAll("input[type='checkbox']:checked")
    const selectedLabels = Array.from(checkedBoxes).map(checkbox => {
      return checkbox.closest("div")?.textContent?.trim()
    }).filter(Boolean)

    this.skillsDivTarget.innerHTML = ""

    if (selectedLabels.length === 0) {
      this.skillsDivTarget.innerHTML = `<span class="text-slate-400">No skills selected</span>`
      return
    }

    selectedLabels.forEach(label => {
      const pill = document.createElement("span")
      pill.className = "bg-amber-100 border-1 border-amber-200 text-gray-800 font-semibold text-sm px-2 py-1 rounded-full"
      pill.textContent = label
      this.skillsDivTarget.appendChild(pill)
    })
  }
}
