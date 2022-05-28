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
          <b-input v-model="name"></b-input>
        </div>

        <div class="mb-2">
          Url:
          <b-input v-model="url"></b-input>
        </div>

        <label class="mb-2">Pre-script Scenario: {Scenario} </label>
      </div>
    </b-card>

    <b-card class="card-elements">
      <template #header>
        <div class="d-flex justify-content-between align-items-center">
          <div class="h6 text-truncate mb-0">Elements</div>
          <b-button
            variant="white"
            class="p-2 cursor-pointer text-muted"
            @click="show(!isEdit, { url: url })"
          >
            <i class="mdi mdi-24px mdi-plus-circle line-height-1"></i>
          </b-button>
        </div>
      </template>

      <b-table responsive small :items="elements" :fields="fields" outlined>
        <template #cell(image)="data" width="150px">
          <img
            v-if="data.item.image"
            :src="data.item.image"
            width="100"
            height="50"
          />
        </template>

        <template #cell(actions)="data">
          <b-button
            variant="white"
            @click="show(isEdit, { ...data.item, url: url })"
          >
            <i class="mdi mdi-pencil"></i>
          </b-button>
          <b-button
            class="btnAction"
            variant="white"
            @click="onDelete(data.item.id)"
          >
            <i class="mdi mdi-delete"></i>
          </b-button>
        </template>
      </b-table>
    </b-card>

    <ElementEditModalVue ref="elementModal"></ElementEditModalVue>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
const { mapState, mapActions } = createNamespacedHelpers("screens");
const elementMapper = createNamespacedHelpers("elements");
import { mapFields } from "vuex-map-fields";
import ElementEditModalVue from "~/components/common/ElementEditModal.vue";
export default {
  name: "ScreenEditDetails",
  components: {
    ElementEditModalVue,
  },
  data() {
    return {
      fields: [
        { key: "image", label: "Image", thStyle: { width: "150px" } },
        "id",
        {
          key: "name",
          label: "Name",
          thStyle: { width: "110px" },
        },
        {
          key: "selector_type",
          label: "Selector Type",
          thStyle: { width: "150px" },
        },

        "selector_path",
        // "screen_id",
        { key: "actions", label: "Actions", thStyle: { width: "100px" } },
      ],
      isEdit: true,
    };
  },

  mounted() {
    this.getScreen(this.$route.params.id);
  },

  computed: {
    ...mapState(["screen"]),
    ...mapFields("screens", {
      name: "screen.name",
      url: "screen.url",
      elements: "screen.elements",
    }),
  },
  methods: {
    ...mapActions(["getScreen"]),
    ...elementMapper.mapActions(["deleteElement"]),
    show(isEdit, data) {
      this.$refs.elementModal.show(isEdit, data);
    },

    onDelete(id) {
      this.$bvModal
        .msgBoxConfirm("Are you sure want to delete this element?", {
          title: "Confirm delete",
          size: "md",
          buttonSize: "sm",
          okVariant: "danger",
          okTitle: "YES",
          cancelTitle: "NO",
          footerClass: "p-2",
          hideHeaderClose: false,
          centered: true,
        })
        .then((value) => {
          if (value) {
            const params = { ...this.screen, elementID: id };
            this.deleteElement(params);
          }
        })
        .catch((err) => {
          // An error occurred
        });
    },
  },
};
</script>
<style lang="scss" scoped>
.card-elements {
  ::v-deep {
    .card-header {
      padding-top: 0;
      padding-bottom: 0;
    }
  }
}
</style>
