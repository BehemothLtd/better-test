<template>
  <div class="container">
    <h4 class="my-4 text-center">CREATE/UPDATE SCENARIO</h4>
    <b-row class="align-items-center">
      <b-col sm="2">
        <label>Name</label>
      </b-col>
      <b-col sm="10">
        <b-input-group class="v-group mt-2 mb-1">
          <b-input placeholder="Tên scenario"></b-input>
        </b-input-group>
      </b-col>
    </b-row>

    <b-row class="align-items-center mb-2">
      <b-col sm="2">
        <label>URL</label>
      </b-col>
      <b-col sm="10">
        <b-input-group class="v-group mt-2 mb-1">
          <b-input placeholder="https://"></b-input>
        </b-input-group>
      </b-col>
    </b-row>

    <b-row class="align-items-center mt-2">
      <b-col sm="2">
        <label>Step</label>
      </b-col>
      <b-col sm="10">
        <b-button v-b-modal.modal-step-scenarios variant="dark">+ Add Step</b-button>
      </b-col>
    </b-row>

    <b-row class="align-items-center mt-2 text-right">
      <b-col sm="12">
        <b-button variant="outline-secondary">Preview</b-button>
        <b-button variant="success">Save</b-button>
      </b-col>
    </b-row>

    <b-modal id="modal-step-scenarios" modal-class="modal-type" hide-header>
      <b-row class="align-items-center">
        <b-col sm="3">
          <label>Element</label>
        </b-col>
        <b-col sm="9">
          <b-form-select></b-form-select>
        </b-col>
      </b-row>
      <ModalStepScenarios></ModalStepScenarios>
    </b-modal>
  </div>
</template>
<script>
import ModalStepScenarios from '@/pages/projects/_id/scenarios/_id/ModalStepScenarios.vue';
export default {
  components: { ModalStepScenarios },
  methods: {
    showModal() {
      this.$refs.modal - type.show();
    },
  },
  mounted() {},
};
</script>
<style>
.unit {
  position: absolute;
  top: 5px;
  right: 20px;
}
</style>
