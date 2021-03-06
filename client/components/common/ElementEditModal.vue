<template>
  <b-modal
    hide-footer
    id="modal"
    ref="elementModal"
    title="Add Templates"
    @hide="hide"
  >
    <ul class="mb-2" v-if="errors.length">
      <li class="errors" v-for="error in errors">{{ error }}</li>
    </ul>
    <label class="font-weight-bold">Element Name <code>*</code></label>
    <b-input v-model="element.name" class="mb-2"></b-input>
    <label class="font-weight-bold">Select Type</label>
    <b-form-select
      v-model="element.selector_type"
      class="mb-2"
      :options="selectorOptions"
    ></b-form-select>
    <label class="font-weight-bold">Selector Path <code>*</code></label>
    <b-input
      class="mb-2"
      v-model="element.selector_path"
      placeholder="/bookstore/book/price[text()]..."
    ></b-input>
    <div class="mt-2 mb-3">
      <div class="d-flex align-items-center">
        <label class="mr-2 mb-0 font-weight-bold">Image</label>
        <b-button size="sm" @click="onCapture" class="mr-2" variant="outline-success"
          >Capture <i class="mdi mdi-image-search"></i>
        </b-button>
        <b-spinner v-if="isBusy" label="Spinning"></b-spinner>
      </div>
    </div>
    <div class="text-center">
      <img
        v-if="element.image"
        :src="element.image"
        style="max-width: 200px; max-height: 200px"
      />
    </div>
    <div class="modal-footer mt-2 py-2">
      <b-button variant="success" @click="submit">Submit</b-button>
    </div>
  </b-modal>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
import _ from "lodash";

const { mapActions } = createNamespacedHelpers("elements");

export default {
  name: "elementModal",
  data() {
    return {
      element: {
        id: null,
        name: "",
        selector_type: "",
        selector_path: "",
        screen_id: "",
        image: "",
      },
      screenUrl: "",
      errors: [],
      isBusy: false,
      isEdit: false,
      selectorOptions: [
        { id: 1, value: "css", text: "CSS" },
        { id: 2, value: "xpath", text: "XPath" },
      ],
    };
  },

  computed: {
    screen_id() {
      this.$route.params.screenId;
    },
  },
  methods: {
    ...mapActions(["createElement", "capImage", "updateElement"]),

    show(isEdit, data) {
      this.$refs.elementModal.show();
      this.screenUrl = data.url;
      this.preScriptId = data.pre_script_id;
      this.isEdit = isEdit;

      if (isEdit) {
        this.element.id = data.id;
        this.element.name = data.name;
        this.element.selector_type = data.selector_type;
        this.element.selector_path = data.selector_path;
        this.element.image = data.image;
        this.element.screen_id = data.screen_id;
      } else {
        this.resetModal();
      }
    },

    async onCapture() {
      try {
        if (this.checkElement()) {
          const params = {
            url: this.screenUrl,
            scenario_id: this.preScriptId,
            selector_type: this.element.selector_type,
            selector_path: this.element.selector_path,
          };

          this.isBusy = true;
          const res = await this.capImage(params);
          this.element.image = res.data.url;
          if (res) {
            this.isBusy = false;
            this.errors = [];
          }
        }
      } catch (error) {
        console.log(error);
        this.isBusy = false;
      }
    },

    resetModal() {
      this.element = {
        name: "",
        selector_path: "",
        selector_type: "css",
        image: "",
      };
      this.errors = [];
    },

    hide() {
      this.resetModal();
      this.$refs.elementModal.isVisible = false;
    },
    submit() {
      if (this.checkElement()) {
        if (this.isEdit) {
          this.$emit("update", _.cloneDeep(this.element));
          this.hide();
        } else {
          this.$emit("create", _.cloneDeep(this.element));
          this.hide();
        }
      }
    },

    checkElement() {
      if (this.element.selector_type && this.element.selector_path) {
        return true;
      }

      this.errors = [];

      if (!this.element.name) {
        this.errors.push("Name required.");
      }

      if (!this.element.selector_type) {
        this.errors.push("Selector type required.");
      }
      if (!this.element.selector_path) {
        this.errors.push("Selector path required.");
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
