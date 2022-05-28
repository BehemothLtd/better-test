<template>
  <div class="container-fluid">
    <b-card>
      <template #header class="py-0 pr-0">
        <div class="d-flex justify-content-between align-items-center">
          <div class="h6 text-truncate mb-0">Elements</div>
          <b-button
            variant="white"
            class="p-2 cursor-pointer text-muted"
            @click="show"
          >
            <i class="mdi mdi-24px mdi-plus-circle line-height-1"></i>
          </b-button>
        </div>
      </template>

      <b-table responsive small :items="items" :fields="fields">
        <template #cell(actions)="data">
          <b-button variant="white">
            <i class="mdi mdi-pencil"></i>
          </b-button>
          <b-button class="btnAction" variant="white">
            <i class="mdi mdi-delete"></i>
          </b-button>
        </template>
      </b-table>
    </b-card>

    <b-card class="mt-5">
      <template #header class="py-0 pr-0">
        <div class="d-flex justify-content-between align-items-center">
          <div class="h6 text-truncate mb-0">Test Case</div>
        </div>
      </template>

      <b-table responsive small :items="items" :fields="fields">
        <template #cell(actions)="data">
          <b-button variant="white">
            <i class="mdi mdi-pencil"></i>
          </b-button>
          <b-button variant="white" class="btnAction" @click="show">
            <i class="mdi mdi-delete"></i>
          </b-button>
        </template>
      </b-table>
    </b-card>

    <ElementEditModalVue ref="elementModal"></ElementEditModalVue>
  </div>
</template>

<script>
import ElementEditModalVue from "~/components/common/ElementEditModal.vue";
export default {
  name: "ScreenEditDetails",
  components: {
    ElementEditModalVue,
  },
  data() {
    return {
      fields: [
        "id",
        "name",
        "selector_type",
        "selector_path",
        "image",
        "screen_id",
        { key: "actions", label: "Actions" },
      ],
      items: [
        {
          id: 1,
          name: "Dickerson",
          selector_type: "Macdonald",
          selector_path: "awesome",
          image: "zvvv",
          screen_id: "111",
        },
      ],

    };
  },
  methods: {
    show() {
      this.$refs.elementModal.show();
    },
  },
};
</script>
<style lang="scss">
.image-element {
}
</style>
