class DesignItem {
  final String image;
  final String title;
  final String description;
  final String likes;
  final String views;

  DesignItem({
    required this.image,
    required this.title,
    required this.description,
    required this.likes,
    required this.views,
  });
}

// Updated to 9 items for a 3x3 grid
final List<DesignItem> designsData = [
  DesignItem(
    image: "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=2564",
    title: "Abstract Flow",
    description: "Modern minimal interface architecture.",
    likes: "842",
    views: "1.2k",
  ),
  DesignItem(
    image: "https://images.unsplash.com/photo-1633167606207-d840b5070fc2?q=80&w=2564",
    title: "Cyber Vision",
    description: "Futuristic dashboard concepts.",
    likes: "1.1k",
    views: "2.4k",
  ),
  DesignItem(
    image: "https://images.unsplash.com/photo-1614850523296-d8c1af93d400?q=80&w=2564",
    title: "Gradient Mesh",
    description: "Exploring organic color transitions.",
    likes: "930",
    views: "1.8k",
  ),
  DesignItem(
    image: "https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?q=80&w=2564",
    title: "Glassmorphism",
    description: "Soft UI and frosted glass effects.",
    likes: "2.1k",
    views: "5.2k",
  ),
  DesignItem(
    image: "https://images.unsplash.com/photo-1618556450991-2f1af64e8191?q=80&w=2564",
    title: "Dark Mode",
    description: "Optimizing contrast for night viewing.",
    likes: "750",
    views: "1.1k",
  ),
  DesignItem(
    image: "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=2564",
    title: "Code Struct",
    description: "Visualizing complex data structures.",
    likes: "1.4k",
    views: "3.1k",
  ),
  DesignItem(
    image: "https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=2564",
    title: "Retro Tech",
    description: "Old school aesthetics in modern web.",
    likes: "620",
    views: "980",
  ),
  DesignItem(
    image: "https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=2564",
    title: "Global Net",
    description: "Connectivity and networking visuals.",
    likes: "1.8k",
    views: "4.0k",
  ),
  DesignItem(
    image: "https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?q=80&w=2564",
    title: "Eco Logic",
    description: "Sustainability meets digital design.",
    likes: "950",
    views: "2.2k",
  ),
];