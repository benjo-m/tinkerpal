import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["image", "currentImageParagraph", "previousButton", "nextButton"]
    static values = { currentIndex: Number, totalImages: Number }

    initialize() {
        this.showCurrentImage()
    }

    next() {
        if (this.currentIndexValue < this.totalImagesValue - 1) {
            this.currentIndexValue++
            this.showCurrentImage()
        }
    }

    previous() {
        if (this.currentIndexValue > 0) {
            this.currentIndexValue--
            this.showCurrentImage()
        }
    }

    showCurrentImage() {
        if (this.imageTargets.length != 0) {
            this.imageTargets.forEach((image, index) => image.hidden = index !== this.currentIndexValue)
            this.currentImageParagraphTarget.textContent = `${this.currentIndexValue + 1} of ${this.totalImagesValue}`
            this.toggleButtonsStyles()
        }
    }

    toggleButtonsStyles() {
        if (this.currentIndexValue == 0) {
            this.previousButtonTarget.classList.add("text-gray-300")
            this.previousButtonTarget.classList.remove("cursor-pointer")
        }
        else {
            this.previousButtonTarget.classList.add("cursor-pointer")
            this.previousButtonTarget.classList.remove("text-gray-300")
        }

        if (this.currentIndexValue == this.totalImagesValue - 1) {
            this.nextButtonTarget.classList.add("text-gray-300")
            this.nextButtonTarget.classList.remove("cursor-pointer")
        }
        else {
            this.nextButtonTarget.classList.add("cursor-pointer")
            this.nextButtonTarget.classList.remove("text-gray-300")
        }
    }
}
