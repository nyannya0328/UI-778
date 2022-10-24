//
//  Home.swift
//  UI-778
//
//  Created by nyannyan0328 on 2022/10/24.
//

import SwiftUI

struct Home: View {
    @State var currentBooks : Book = sampleBooks.first!
    var body: some View {
        VStack{
            
            HeaderView()
            
            
            BooksView()
            
            BookDetailView()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
    }
    func indexOF(book : Book)->Int{
        
        if let index = sampleBooks.firstIndex(of: book){
            
            return index
        }
        
        
        return 0
        
    }
    @ViewBuilder
    func BookDetailView ()->some View{
        
        VStack{
            
            GeometryReader{
                
                let size = $0.size
             
                HStack(spacing: 0) {
                    
                    ForEach(sampleBooks){book in
                        
                        let index = indexOF(book: book)
                        let currentIndex = indexOF(book: currentBooks)
                        
                        VStack(alignment: .leading,spacing: 13) {
                            
                            Text(book.title)
                                .font(.largeTitle)
                                .foregroundColor(.gray.opacity(0.8))
                                .offset(x:CGFloat(currentIndex) * -(size.width + 30))
                                .opacity(currentIndex == index ? 1 : 0)
                                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex < index ? 0.1 : 0), value: currentIndex == index)
                            
                            Text("By \(book.author)")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.purple.opacity(0.6))
                                .offset(x:CGFloat(currentIndex) * -(size.width + 30))
                                .opacity(currentIndex == index ? 1 : 0)
                                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex > index ? 0.2 : 0), value: currentIndex == index)
                            
                                
                            
                        }
                        .frame(width: size.width + 30,alignment: .leading)
                        
                    }
                    
                    
                }
            }
            .frame(height:100)
            .padding(.horizontal,13)
            
            
            ZStack(alignment:.leading){
                
                Capsule()
                    .fill(.gray.opacity(0.3))
                    
                
                GeometryReader{
                    
                    let size = $0.size
                 
                    Capsule()
                        .fill(Color("Green"))
                        .frame(width: CGFloat(indexOF(book: currentBooks)) / CGFloat(sampleBooks.count - 1) * size.width)
                    
                        
                }
                
                
            }
            .frame(height: 4)
            .padding(.top,10)
            .padding([.horizontal,.bottom],10)
        }
    
        
    }
    @ViewBuilder
    func BooksView ()->some View{
        
        TabView(selection: $currentBooks) {
            
            ForEach(sampleBooks){book in
                
                BookView(book: book)
                    .tag(book)
                
            }
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background{
         
            Image("BG")
                .resizable()
                .aspectRatio(contentMode: .fit)
                
        }
        
    }
    @ViewBuilder
    func BookView(book : Book)->some View{
        
        GeometryReader{
            
            let size = $0.size
            let rect = $0.frame(in: .global)
            
            let minX = (rect.minX - 50) < 0 ? (rect.minX - 50) : -(rect.minX - 50)
            
            let progress = minX / rect.width
            
            let rotation = progress * 45
         
            ZStack{
                
                IsometricView(depath: 15) {
                    
                
                    
                } bottom: {
                    
                    Color.white
                    
                } side: {
                    
                    Color.white
                }
                .frame(width: size.width / 1.2,height: size.height / 1.5)
                .shadow(color: .black.opacity(0.17), radius: 5,x:15,y:5)
                .shadow(color: .black.opacity(0.1), radius: 5,x:-15,y:-5)

                
                Image(book.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width / 1.2,height: size.height / 1.5)
                    .shadow(color: .black.opacity(0.17), radius: 5,x:15,y:5)
                    .clipped()
                    .rotation3DEffect(.init(degrees: rotation), axis: (x: 0, y: 1, z: 0),anchor: .leading,perspective: 1)
                    .modifier(CustomProjection(value: 1 + (-progress < 1 ? progress : -1.0)))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.horizontal,50)
        
        
    }
    @ViewBuilder
    func HeaderView ()->some View{
     
        HStack{
            
            Text("Bookio")
                .font(.title.bold())
            
            Spacer()
            
            
            HStack{
                
                Button {
                    
                } label: {
                    
                   Image(systemName: "books.vertical")
                        .font(.title2)
                      
                    
                    
                }
                
                
                Button {
                    
                } label: {
                    
                   Image(systemName: "book.closed")
                        .font(.title2)
                    
                    
                }
            
            }
            .foregroundColor(.gray)
        }
        .padding(15)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

