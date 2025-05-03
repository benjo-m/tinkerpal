import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["image"]
    static values = { currentIndex: Number, totalImages: Number }

    initialize() {
        this.showCurrentSlide()
    }

    next() {
        if (this.currentIndexValue < this.totalImagesValue - 1) {
            this.currentIndexValue++
            this.showCurrentSlide()
        }
    }

    previous() {
        if (this.currentIndexValue > 0) {
            this.currentIndexValue--
            this.showCurrentSlide()
        }
    }

    showCurrentSlide() {
        this.imageTargets.forEach((image, index) => {
            image.hidden = index !== this.currentIndexValue
        });
    }
}
