<template>
  <b-modal ref="modal" hide-header hide-footer>
    <b-row class="align-items-center mt-3">
      <b-col sm="3">
        <label>Action :</label>
      </b-col>
      <b-col sm="9">
        <b-form-select
          v-model="step.command"
          :options="actions"
        ></b-form-select>
      </b-col>
    </b-row>
    <b-row v-if="step.command == 'open'" class="align-items-center mt-3">
      <b-col sm="3">
        <label>Value</label>
      </b-col>
      <b-col sm="9">
        <b-input v-model="step.value" placeholder="http://asdasd"></b-input>
      </b-col>
    </b-row>
    <b-row v-if="step.command == 'input'" class="align-items-center mt-3">
      <b-col sm="3">
        <label>Value</label>
      </b-col>
      <b-col sm="9">
        <b-input v-model="step.value" placeholder="value"></b-input>
      </b-col>
    </b-row>
    <div v-if="step.command == 'wait'">
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label>Wait for</label>
        </b-col>
        <b-col sm="9">
          <b-form-select
            v-model="selected_wait"
            :options="waits"
          ></b-form-select>
        </b-col>
      </b-row>
      <b-row v-if="selected_wait == 'seconds'" class="align-items-center mt-3">
        <b-col sm="3">
          <label>Value</label>
        </b-col>
        <b-col sm="9">
          <div class="postion-relative">
            <b-input v-model="step.value" placeholder="10"></b-input>
            <span class="unit">-/+(s)</span>
          </div>
        </b-col>
      </b-row>
      <b-row v-else class="align-items-center mt-3">
        <b-col sm="3">
          <label>Element</label>
        </b-col>
        <b-col sm="9">
          <div class="postion-relative">
            <b-form-select></b-form-select>
          </div>
        </b-col>
      </b-row>
    </div>
    <div v-if="step.command == 'scenario'">
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label>Scenario</label>
        </b-col>
        <b-col sm="9">
          <b-form-select></b-form-select>
        </b-col>
      </b-row>
    </div>
    <div v-if="step.command == 'assert'">
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label>Element</label>
        </b-col>
        <b-col sm="9">
          <div class="postion-relative">
            <b-form-select></b-form-select>
          </div>
        </b-col>
      </b-row>
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label>Equal</label>
        </b-col>
        <b-col sm="9">
          <b-input v-model="step.value" placeholder="value"></b-input>
        </b-col>
      </b-row>
    </div>
    <div class="mt-3 text-right">
      <b-button variant="primary" @click="submit">Submit</b-button>
    </div>
  </b-modal>
</template>
<script>
import _ from "lodash";
export default {
  data() {
    return {
      step: {
        command: "click",
        value: "",
      },
      selected_wait: "element",
      actions: [
        { value: "click", text: "Click" },
        { value: "open", text: "Open" },
        { value: "input", text: "Input" },
        { value: "wait", text: "Wait" },
        { value: "scenario", text: "Scenario" },
        { value: "assert", text: "Assert" },
      ],
      waits: [
        { value: "element", text: "Element" },
        { value: "seconds", text: "Seconds" },
      ],
    };
  },
  methods: {
    submit() {
      this.$emit("submit", _.cloneDeep(this.step));
      this.hide();
    },
    resetModal() {
      this.step.command = "click";
      this.step.value = "";
    },
    hide() {
      this.resetModal();
      this.$refs.modal.isVisible = false;
    },
    show() {
      this.$refs.modal.show();
    },
  },
};
</script>
