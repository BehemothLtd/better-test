<template>
  <div>
    <b-row class="align-items-center mt-3">
      <b-col sm="3">
        <label>Action :</label>
      </b-col>
      <b-col sm="9">
        <b-form-select
          v-model="selected_action"
          :options="actions"
        ></b-form-select>
      </b-col>
    </b-row>
    <b-row v-if="selected_action == 'open'" class="align-items-center mt-3">
      <b-col sm="3">
        <label>Value</label>
      </b-col>
      <b-col sm="9">
        <b-input placeholder="http://asdasd"></b-input>
      </b-col>
    </b-row>
    <b-row v-if="selected_action == 'input'" class="align-items-center mt-3">
      <b-col sm="3">
        <label>Value</label>
      </b-col>
      <b-col sm="9">
        <b-input placeholder="value"></b-input>
      </b-col>
    </b-row>
    <div v-if="selected_action == 'wait'">
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
            <b-input placeholder="10"></b-input>
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
    <div v-if="selected_action == 'scenario'">
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label>Scenario</label>
        </b-col>
        <b-col sm="9">
          <b-form-select></b-form-select>
        </b-col>
      </b-row>
    </div>
    <div v-if="selected_action == 'assert'">
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
          <b-input placeholder="value"></b-input>
        </b-col>
      </b-row>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      selected_action: "click",
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
};
</script>
