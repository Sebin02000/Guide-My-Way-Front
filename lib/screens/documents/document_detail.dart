import 'package:flutter/material.dart';
import 'package:maps_app/models/documents.dart';

import '../../utils/apptheme.dart';

class DocumentDetailScreen extends StatefulWidget {
  const DocumentDetailScreen(this.doc, {Key? key}) : super(key: key);
  final DocmnetRe doc;

  @override
  State<DocumentDetailScreen> createState() => _DocumentDetailScreenState();
}

class _DocumentDetailScreenState extends State<DocumentDetailScreen> {
  int currentStep = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentStep = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [];
    for (int i = 0; i < widget.doc.steps.length; i++) {
      steps.add(Step(
        title: Text("Step ${i + 1}"),
        content: Text(widget.doc.steps[i]),
        isActive: true,
      ));
    }
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: ThemeConfig.textTheme.headline2,
        title: Text(
          widget.doc.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Text(
                  "How to apply for ${widget.doc.title}",
                  style: ThemeConfig.textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.doc.description,
                style: ThemeConfig.textTheme.headline2,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Certificates required",
                style: ThemeConfig.textTheme.headline3,
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.doc.certificates.length,
                itemBuilder: (context, ints) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const Icon(Icons.collections_bookmark_outlined),
                      title: Text(widget.doc.certificates[ints]),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Steps",
                style: ThemeConfig.textTheme.headline3,
              ),
              const SizedBox(
                height: 20,
              ),
              Stepper(
                currentStep: currentStep,
                steps: steps,
                onStepContinue: () {
                  if (currentStep < widget.doc.steps.length - 1) {
                    setState(() {
                      currentStep = currentStep + 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (currentStep > 0) {
                    setState(() {
                      currentStep = currentStep - 1;
                    });
                  }
                },
                type: StepperType.vertical,
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
