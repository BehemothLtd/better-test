<template>
  <b-card>
    <template #header class="py-0 pr-0">
      <div class="d-flex justify-content-between align-items-center">
        <div class="h6 text-truncate mb-0">TEST HISTORY</div>
      </div>
    </template>

    <b-table responsive small :items="test_session" :fields="testSession">
      <template #cell(index)="data">Case{{ data.index + 1 }} </template>
    </b-table>
  </b-card>
</template>
<script>
import { createNamespacedHelpers } from "vuex";
const { mapState, mapActions } = createNamespacedHelpers("test_histories");

export default {
  name: "TestSection",

  data() {
    return {
      testSession: [
        { key: "index", label: "Case" },
        { key: "test_case_name", label: "Test case name" },
        { key: "result", label: "Status" },
        { key: "created_at", label: "Time" },
      ],
      test_session: [],
    };
  },

  created() {
    this.getTestSession(this.$route.params.id);
  },
  computed: {
    ...mapState(["test_session"]),
  },
  methods: {
    ...mapActions(["getTestSession"]),
  },
};
</script>
