<script>
export default {
  data() {
    return {};
  },
  methods: {
  },
  props : ["infoSalle"]
}


</script>

<template>
  <div>
    {{ infoSalle[0].summary }}
  </div>

</template>