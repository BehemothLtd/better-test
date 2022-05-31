<template>
  <tbody>
    <tr>
      <td>
        <nuxt-link
          :to="`/projects/${record.project_id}/screens/${record.screen_id}/test_cases/${record.test_case_id}`"
        >
          {{ record.test_case_name }}
        </nuxt-link>
      </td>
      <td>{{ record.result }}</td>
      <td>{{ record.created_at }}</td>
      <td>
        <span role="button" class="text-primary" @click="show = !show">
          Detail
        </span>
      </td>
    </tr>
    <tr v-show="show">
      <td colspan="4">
        <div v-if="record.message" class="text-danger">
          {{ record.message }}
        </div>

        <div v-if="record.images.length">
          <table class="table">
            <thead>
              <tr>
                <th>Step</th>
                <th>Image</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(image, i) in record.images" :key="i">
                <td>{{ image.step }}</td>
                <td>
                  <a :href="image.image" target="_blank">{{ image.image }}</a>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </td>
    </tr>
  </tbody>
</template>

<script>
export default {
  props: {
    record: Object,
  },

  data() {
    return {
      show: false,
    };
  },
};
</script>
