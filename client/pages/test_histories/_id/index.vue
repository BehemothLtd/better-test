<template>
  <div>
    <div class="container">
      <div class="text-center my-4">
        <span class="asult-title">Test History</span>
      </div>
    </div>

    <table class="table table-bordered table-asult">
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
  </div>
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
<style>
.asult-title {
  font-size: 30px;
  font-weight: bold;
  background: linear-gradient(0deg, #79d8e8 35%, rgba(245, 248, 244, 0) 0);
}
.table-asult th {
  background-color: #d1ecf1;
}
</style>