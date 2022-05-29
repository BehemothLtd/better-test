<template>
  <b-card>
    <template #header class="py-0 pr-0">
      <div class="d-flex justify-content-between align-items-center">
        <div class="h6 text-truncate mb-0">TEST HISTORY</div>
      </div>
    </template>

    <table class="table table-bordered">
      <thead>
        <tr>
          <th>Case</th>
          <th>Status</th>
          <th>Time</th>
          <th>Actions</th>
        </tr>
      </thead>
      <TestCaseResultDetail
        v-for="ts in test_session"
        :key="ts.id"
        :record="ts"
      ></TestCaseResultDetail>
    </table>
  </b-card>
</template>

<script>
import TestCaseResultDetail from "@/components/common/TestCaseResultDetail";
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
  components: { TestCaseResultDetail },
};
</script>
