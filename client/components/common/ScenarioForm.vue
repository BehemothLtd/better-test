<template>
  <div>
    <b-row class="align-items-center">
      <b-col sm="2">
        <label>Name</label>
      </b-col>
      <b-col sm="10">
        <b-input-group class="v-group mt-2 mb-1">
          <b-input v-model="form.name" placeholder=""></b-input>
        </b-input-group>
      </b-col>
    </b-row>

    <b-row class="align-items-center mb-2">
      <b-col sm="2">
        <label>URL</label>
      </b-col>
      <b-col sm="10">
        <b-input-group class="v-group mt-2 mb-1">
          <b-input v-model="form.url" placeholder="https://"></b-input>
        </b-input-group>
      </b-col>
    </b-row>

    <b-row class="align-items-center mt-2">
      <b-col sm="2">
        <label>Step</label>
      </b-col>
      <b-col sm="10">
        <b-button @click="addStep" variant="dark">+ Add Step</b-button>
      </b-col>
    </b-row>

    <table class="table table-bordered mt-3">
      <thead>
        <tr>
          <td>Action</td>
          <td>Element</td>
          <td>Argument</td>
          <td></td>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(step, index) in form.steps" :key="index">
          <td>{{ step.command }}</td>
          <td>{{ step.name }}</td>
          <td>{{ step.value }}</td>
          <td>
            <span role="button" @click="editStep(step, index)">
              <i class="mdi mdi-pencil"></i>
            </span>
            <span role="button" @click="removeStep(index)">
              <i class="mdi mdi-delete"></i>
            </span>
          </td>
        </tr>
      </tbody>
    </table>

    <b-row class="align-items-center mt-2 text-right">
      <b-col sm="12">
        <b-button variant="success" @click="saveForm">Save</b-button>
      </b-col>
    </b-row>

    <ModalStepTestcase
      ref="stepTestCaseModal"
      @create="onCreateStep"
      @update="onUpdateStep"
    ></ModalStepTestcase>
  </div>
</template>

<script>
import ModalStepTestcase from "@/components/common/ModalStepTestcase";

export default {
  components: {
    ModalStepTestcase,
  },

  props: {
    form: { type: Object, default: () => ({ steps: [] }) },
  },

  data() {
    return {
      index: -1,
    };
  },

  methods: {
    addStep() {
      this.$refs.stepTestCaseModal.show();
    },

    editStep(data, index) {
      this.$refs.stepTestCaseModal.show(data);
      this.index = index;
    },

    removeStep(index) {
      this.form.steps.splice(index, 1);
    },

    onCreateStep(step) {
      this.form.steps.push(step);
    },

    onUpdateStep(step) {
      this.form.steps.splice(this.index, 1, step);
    },

    saveForm() {
      this.$emit("save");
    },
  },
};
</script>

<style>
.unit {
  position: absolute;
  top: 5px;
  right: 20px;
}
</style>
