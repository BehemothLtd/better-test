<template>
  <div class="container">
    <div class="text-center my-4">
      <span class="screens-title">Screen</span>
    </div>

    <div>
      <div class="mb-2 d-flex">
        <b-col sm="3" class="font-weight-bold"> Name: </b-col>
        <b-col sm="9">
          <b-input v-model="name"></b-input>
        </b-col>
      </div>

      <div class="mb-2 d-flex">
        <b-col sm="3" class="font-weight-bold"> Url: </b-col>
        <b-col sm="9">
          <b-input v-model="url"></b-input>
        </b-col>
      </div>

      <div class="mb-2 d-flex">
        <b-col sm="3" class="font-weight-bold"> Pre-script Scenario: </b-col>
        <b-col sm="9">
          <b-select
            v-model="preScriptId"
            :options="scenarios"
            text-field="name"
            value-field="id"
          ></b-select>
        </b-col>
      </div>
    </div>

    <b-card class="card-elements mt-5 card-screens">
      <template #header>
        <div class="d-flex justify-content-between align-items-center bg-screens">
          <div class="h6 text-truncate mb-0">Elements</div>
          <b-button
            variant="white"
            class="p-2 cursor-pointer text-muted"
            @click="show(!isEdit, { url: url })"
          >
            <i class="mdi mdi-24px mdi-plus-circle line-height-1 text-warning"></i>
          </b-button>
        </div>
      </template>

      <b-table responsive small :items="elements" :fields="fields" outlined>
        <template #cell(image)="data" width="150px">
          <img
            v-if="data.item.image"
            :src="data.item.image"
            style="max-width: 100px; max-height: 100px"
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

    <div class="text-right">
      <b-button variant="warning" class="text-white w-100px mt-3" @click="save">Save</b-button>
    </div>

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
      scenarios: [],
    };
  },

  async mounted() {
    this.getScreen(this.$route.params.screenId);
    const res = await this.$axios.get(
      `/scenarios?project_id=` + this.$route.params.id
    );
    this.scenarios = res.data;
  },

  computed: {
    ...mapState(["screen"]),
    ...mapFields("screens", {
      name: "screen.name",
      url: "screen.url",
      elements: "screen.elements",
      preScriptId: "screen.pre_script_id",
      screen: "screen",
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

    async save() {
      try {
        await this.$axios.put(
          `/screens/${this.$route.params.screenId}`,
          this.screen
        );
        this.getScreen(this.$route.params.screenId);
        this.$toast.success("Successfully");
      } catch {
        this.$toast.error("Failed");
      }
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
.screens-title {
  font-size: 30px;
  font-weight: bold;
  background: linear-gradient(0deg, #ffdf78 35%, rgba(245, 248, 244, 0) 0);
}
.card-screens .card-header {
  background-color: #fff3cd;
}
.w-100px {
  width: 100px;
}
</style>
