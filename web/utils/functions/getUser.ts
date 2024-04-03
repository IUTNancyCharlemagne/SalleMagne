const getUser = async () => {
  const user = await useSession();

  return session.value!.user;
};

export default getUser;
