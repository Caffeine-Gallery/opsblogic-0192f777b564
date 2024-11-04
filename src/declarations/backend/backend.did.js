export const idlFactory = ({ IDL }) => {
  const BlogPost = IDL.Record({
    'id' : IDL.Nat,
    'title' : IDL.Text,
    'content' : IDL.Text,
    'timestamp' : IDL.Int,
  });
  return IDL.Service({
    'createPost' : IDL.Func([IDL.Text, IDL.Text], [BlogPost], []),
    'getAllPosts' : IDL.Func([], [IDL.Vec(BlogPost)], ['query']),
    'getPost' : IDL.Func([IDL.Nat], [IDL.Opt(BlogPost)], ['query']),
    'initialize' : IDL.Func([], [], []),
  });
};
export const init = ({ IDL }) => { return []; };
