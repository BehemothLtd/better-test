<template>
  <b-modal
    hide-footer
    id="modal"
    ref="elementModal"
    title="Add Templates"
    @hide="hide"
  >
    <ul class="mb-2" v-if="element.errors.length">
      <li class="errors" v-for="error in element.errors">{{ error }}</li>
    </ul>

    <label>Element Name <code>*</code></label>
    <b-input v-model="name" class="mb-2"></b-input>
    <label>Select Type</label>
    <b-form-select
      v-model="selector_type"
      class="mb-2"
      :options="selectorOptions"
    ></b-form-select>
    <label>Selector Path <code>*</code></label>
    <b-input
      class="mb-2"
      v-model="selector_path"
      placeholder="/bookstore/book/price[text()]..."
    ></b-input>
    <div class="mt-2 mb-3">
      <label>Image</label>
      <b-button size="sm" @click="onCapture"
        >Capture <i class="mdi mdi-image-search"></i
      ></b-button>
    </div>
    <div class="text-center">
      <img :src="image" width="200" height="200" />
    </div>
    <div class="modal-footer mt-2 py-2">
      <b-button variant="primary" @click="submit">Submit</b-button>
    </div>
  </b-modal>
</template>
<script>
import { createNamespacedHelpers } from "vuex";
import { mapFields } from "vuex-map-fields";
const { mapState, mapActions } = createNamespacedHelpers("elements");

export default {
  name: "elementModal",
  data() {
    return {
      element: {
        errors: [],
        // name: "",
        // selector_type: "CSS",
        // selector_path: "",
        // image: "",
        // screen_id: 1,
      },
      selectorOptions: [
        { id: 1, value: "css", text: "CSS" },
        { id: 2, value: "xpath", text: "XPath" },
      ],
    };
  },
  computed: {
    ...mapFields("elements", {
      name: "element.name",
      selector_type: "element.selector_type",
      selector_path: "element.selector_path",
      image: "element.image",
      screen_id: "element.screen_id",
    }),
    screen_id() {
      this.$route.params;
    },
  },
  methods: {
    ...mapActions(["createElement", "capImage"]),

    show() {
      this.$refs.elementModal.show();
    },

    onCapture() {
      if (this.checkElement()) {
        this.capImage();
      }
    },

    resetModal() {
      this.name = "";
      this.selector_path = "";
      this.selector_type = "";
      this.element.errors = [];
    },

    hide() {
      this.resetModal();
      this.$refs.elementModal.isVisible = false;
    },
    submit() {
      if (this.checkElement()) {
        const res = this.createElement();
        if (res) {
          this.hide();
          this.$toast.success("Successfully");
        }
      }
    },

    checkElement() {
      if (this.selector_type && this.selector_path) {
        return true;
      }

      this.errors = [];

      if (!this.selector_type) {
        this.element.errors.push("Selector type required.");
      }
      if (!this.selector_path) {
        this.element.errors.push("Selector path required.");
      }
    },
  },
};
</script>
<style lang="scss" scoped>
.errors {
  color: #cb3837;
  font-size: 16px;
  font-style: italic;
}
</style>
