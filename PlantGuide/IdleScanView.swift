////
////  IdleScanView.swift
////  PlantGuide
////
////  Created by (non work) on 15.10.20.
////
//
//import SwiftUI
//
//struct IdleScanView: View {
//
//    @State private var isImagePickerVisible: Bool = false
//    @State private var isAnimating = false
//
//    @State private var showActionSheet: Bool = false
//    @State private var showImageSelector: Bool = false
//    @State private var sourceType: UIImagePickerController.SourceType = .camera
//    @Binding var showClassification: Bool
//
//    @State var image: UIImage?
//    @Binding var selected: Int?
//
//    let feedback = UIImpactFeedbackGenerator(style: .light)
//    let green = Color(red: 0.267, green: 0.451, blue: 0.216)
//
//    var actionSheet: ActionSheet {
//        ActionSheet(
//         title: Text("Choose your Input:"),
//         message: Text("How do you want to scan your plants?"),
//            buttons:[
//                .default(Text("Take a Photo")){
//                    self.showImageSelector = true
//                    self.sourceType = .camera
//                },
//                .default(Text("Photo Library")) {
//                    self.showImageSelector = true
//                    self.sourceType = .photoLibrary
//                },
//                .cancel()
//        ])
//    }
//
//
//
//    var body: some View {
//        ZStack {
//            VStack() {
//                ZStack {
//                    ZStack {
//                        Rectangle()
//                            .cornerRadius(20)
//                            .foregroundColor(Color(.systemBackground))
//                            .frame(width: 105, height: 105)
//                            .overlay(
//                                ZStack {
//                                    LinearGradient(gradient: Gradient(colors: [Color(.systemBackground),  Color(.systemGray6)]), startPoint: .top, endPoint: .bottom)
//                                    .frame(width: 105.0, height: 105.0)
//                                    .cornerRadius(20)
//                                        .shadow(color: Color(self.showActionSheet ? .systemBackground : .clear), radius: 2, x: -2, y: -2)
//                                            .clipShape(
//                                                RoundedRectangle(cornerRadius: 20)
//                                        )
//                                    RoundedRectangle(cornerRadius: 20)
//                                    .stroke(Color(UIColor.black).opacity(0), lineWidth: 3)
//                                        .shadow(color: Color(self.showActionSheet ? UIColor.black : .clear).opacity(0.2), radius: 2, x: 2, y: 2)
//                                        .clipShape(
//                                            RoundedRectangle(cornerRadius: 20)
//                                        )
//                                }
//                            )
//                            .padding(.top, 20)
//                            .animation(Animation.easeInOut(duration: 0.4))
//                    }
//                    .frame(width: 127, height: 122)
//                    .shadow(color: Color(UIColor.black).opacity(self.showActionSheet ? 0 : 0.02), radius: 4, x: 5, y: 5)
//                    .shadow(color: Color(.systemGray4).opacity(0.1), radius: 5, x: -5, y: -5)
//                    .animation(Animation.easeInOut(duration: 0.4))
//
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, dash: [38.2], dashPhase: isAnimating ? 58.8 : 135))
//                            .foregroundColor(Color(.systemGray4))
//                            .frame(width: self.showActionSheet ? 0 : 80, height: self.showActionSheet ? 0 : 80)
//
//
//
//                        VStack(alignment: .center) {
//                            ZStack {
//                                LogoAsset()
//                                    .stroke(lineWidth: 5)
//                                    .foregroundColor(green)
//                                    .frame(width: self.showActionSheet ? 35 : 40, height: self.showActionSheet ? 35 : 40)
//
//                                LogoAsset()
//                                    .stroke(lineWidth: 5)
//                                    .scaleEffect(isAnimating ? 1.5 : 1)
//                                    .opacity(isAnimating ? 0 : 0.5)
//                                    .foregroundColor(green)
//                                    .frame(width: self.showActionSheet ? 35 : 40, height: self.showActionSheet ? 35 : 40)
//                                    .animation(Animation.interpolatingSpring(stiffness: 5.0, damping: 20.0).repeatForever(autoreverses: false))
//                            }
//
//                            Text("Scan")
//                                .font(.caption)
//                                .fixedSize(horizontal: false, vertical: true)
//                                .multilineTextAlignment(.center)
//                                .lineLimit(2)
//                                .foregroundColor(.primary)
//                                .opacity(self.showActionSheet ? 0.5 : 1)
//                        }
//
//                    }
//                    .padding(.top, 20)
//                    .foregroundColor(Color(.systemGray4).opacity(0.2))
//                    .frame(height: 85)
//                    .animation(Animation.interpolatingSpring(stiffness: 5.0, damping: 20.0))
//                    .onAppear() {self.isAnimating = true}
//                }
//
//                Spacer()
//
//            }.frame(width: 145, height: 140)
//            .onTapGesture {
//                    withAnimation(Animation.easeInOut.delay(1)) {
//                        self.showActionSheet = true
//                        self.feedback.impactOccurred()
//                    }
//                }.actionSheet(isPresented: $showActionSheet, content: {
//                self.actionSheet })
//                .sheet(isPresented: $showImageSelector) {
//                    ImagePicker(image: self.$image, isImagePickerVisible: self.$showImageSelector, showClassification: self.$showClassification, sourceType: self.sourceType).edgesIgnoringSafeArea(.all)
//            }
//
//            Text("").sheet(isPresented: $showClassification) {
//                ClassificationView(image: self.$image)
//            }
//        }
//        .frame(width: 120, height: 150.0)
//        .clipped()
//        .scaleEffect(0.9)
//    }
//}
//
//struct IdleScanView_Preview: PreviewProvider {
//    static var previews: some View {
//        IdleScanView(showClassification: Binding.constant(false), selected: Binding.constant(2))
//            .previewLayout(.fixed(width: 300, height: 150))
//    }
//}
