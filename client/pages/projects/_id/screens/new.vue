<template>
  <div class="container-fluid">
    <b-card class="mb-3">
      <template #header class="py-0 pr-0">
        <div class="d-flex justify-content-between align-items-center">
          <div class="h6 text-truncate mb-0">Screen</div>
        </div>
      </template>

      <div>
        <div class="mb-2">
          Name:
          <b-input v-model="screen.name"></b-input>
        </div>

        <div class="mb-2">
          Url:
          <b-input v-model="screen.url"></b-input>
        </div>

        <label class="mb-2">
          Pre-script Scenario:
          <b-select
            v-model="screen.pre_script_id"
            :options="scenarios"
            text-field="name"
            value-field="id"
          ></b-select>
        </label>
      </div>
    </b-card>

    <b-card class="card-elements mb-3">
      <template #header>
        <div class="d-flex justify-content-between align-items-center">
          <div class="h6 text-truncate mb-0">Elements</div>
          <b-button
            variant="white"
            class="p-2 cursor-pointer text-muted"
            @click="createElement()"
          >
            <i class="mdi mdi-24px mdi-plus-circle line-height-1"></i>
          </b-button>
        </div>
      </template>

      <div class="table-responsive">
        <table class="table b-table table-sm border">
          <thead>
            <tr>
              <th>Image</th>
              <th>Name</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(element, index) in elements" :key="index">
              <td>
                <img
                  v-if="element.image"
                  :src="element.image"
                  style="max-width: 100px; max-height: 100px"
                />
              </td>
              <td>
                {{ element.name }}
              </td>
              <td>
                <b-button variant="white" @click="editElement(element, index)">
                  <i class="mdi mdi-pencil"></i>
                </b-button>
                <b-button
                  class="btnAction"
                  variant="white"
                  @click="onDelete(element)"
                >
                  <i class="mdi mdi-delete"></i>
                </b-button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </b-card>

    <div class="text-right">
      <b-button variant="primary" @click="save">Save</b-button>
    </div>

    <ElementEditModal
      ref="elementModal"
      @create="onCreate"
      @update="onUpdate"
    ></ElementEditModal>
  </div>
</template>

<script>
import ElementEditModal from "~/components/common/ElementEditModal.vue";

export default {
  name: "ScreenEditDetails",
  components: {
    ElementEditModal,
  },
  data() {
    return {
      scenarios: [],
      screen: {
        name: "",
        url: "",
        pre_script_id: "",
      },
      elements: [],
      editingIndex: -1,
    };
  },

  computed: {
    projectId() {
      return this.$route.params.id;
    },
  },

  async mounted() {
    const res = await this.$axios.get(
      `/scenarios?project_id=` + this.$route.params.id
    );
    this.scenarios = res.data;
  },

  methods: {
    createElement() {
      this.$refs.elementModal.show(false, {
        url: this.screen.url,
        pre_script_id: this.screen.pre_script_id,
      });
    },

    editElement(data, index) {
      this.$refs.elementModal.show(true, {
        ...data,
        url: this.screen.url,
        pre_script_id: this.screen.pre_script_id,
      });
      this.editingIndex = index;
    },

    onCreate(element) {
      this.elements.push(element);
    },

    onUpdate(element) {
      this.elements.splice(this.editingIndex, 1, element);
    },

    onDelete(index) {
      this.elements.splice(index, 1);
    },

    async save() {
      try {
        await this.$axios.post("screens", {
          ...this.screen,
          project_id: this.projectId,
          elements_attributes: this.elements,
        });
        this.$router.push(`/projects/${this.projectId}`);
        this.$toast.success("Successfully");
      } catch {
        this.$toast.error("Failed");
      }
    },
  },
};
</script>
